import { expect, test } from '@playwright/test';
import { spawn } from 'child_process';
import fs from 'fs';
import http from 'http';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const moduleRoot = path.resolve(__dirname, '..');
const siteDir = path.join(moduleRoot, 'site');
const publicDir = path.join(siteDir, 'public');
const demoBase = 'http://localhost:1414';

let serverProcess: ReturnType<typeof spawn> | undefined;

function waitForServer(port: number, retries = 20, delay = 250): Promise<void> {
  return new Promise((resolve, reject) => {
    const attempt = (remaining: number) => {
      const request = http.get({ hostname: 'localhost', port, path: '/' }, (response) => {
        response.resume();
        resolve();
      });
      request.on('error', () => {
        if (remaining <= 0) {
          reject(new Error('Server did not start in time'));
          return;
        }
        setTimeout(() => attempt(remaining - 1), delay);
      });
    };
    attempt(retries);
  });
}

test.beforeAll(async () => {
  fs.rmSync(publicDir, { recursive: true, force: true });
  const buildCommand = ['-s', 'site', '-d', 'public', '-b', demoBase];
  const buildResult = spawn('hugo', buildCommand, { cwd: moduleRoot, stdio: 'inherit' });

  await new Promise<void>((resolve, reject) => {
    buildResult.on('error', reject);
    buildResult.on('exit', (code) => {
      if (code === 0) {
        resolve();
      } else {
        reject(new Error(`Hugo build failed with code ${code}`));
      }
    });
  });

  serverProcess = spawn('python3', ['-m', 'http.server', '1414'], {
    cwd: publicDir,
    stdio: 'ignore',
  });
  await waitForServer(1414);
});

test.afterAll(async () => {
  serverProcess?.kill();
});

test('shortcode embeds render lite-youtube elements and load iframe on play', async ({ page }) => {
  await page.goto(`${demoBase}/shortcodes/`);
  const embeds = page.locator('lite-youtube');
  await expect(embeds).toHaveCount(3);

  const firstEmbed = embeds.first();
  await expect(firstEmbed).toHaveAttribute('videoid', 'dQw4w9WgXcQ');
  await expect(firstEmbed.locator('.lty-playbtn')).toBeVisible();

  await firstEmbed.locator('.lty-playbtn').click();
  await expect(firstEmbed.locator('iframe')).toHaveAttribute(
    'src',
    /https:\/\/www.youtube-nocookie.com\/embed\/dQw4w9WgXcQ/
  );
});

test('partial embed uses locally cached preview and initializes the custom element', async ({ page }) => {
  await page.goto(`${demoBase}/partials-demo/`);
  const partialEmbed = page.locator('lite-youtube');
  await expect(partialEmbed).toHaveCount(1);
  await expect(partialEmbed).toHaveAttribute('videoid', 'dQw4w9WgXcQ');
  const styleAttribute = (await partialEmbed.getAttribute('style')) ?? '';
  expect(styleAttribute).toMatch(/ytimg|googleusercontent|\/assets\/img\//);

  const isRegistered = await page.evaluate(() => Boolean(customElements.get('lite-youtube')));
  expect(isRegistered).toBe(true);

  await partialEmbed.locator('.lty-playbtn').click();
  await expect(partialEmbed.locator('iframe')).toHaveAttribute(
    'src',
    /https:\/\/www.youtube-nocookie.com\/embed\/dQw4w9WgXcQ/
  );
});
