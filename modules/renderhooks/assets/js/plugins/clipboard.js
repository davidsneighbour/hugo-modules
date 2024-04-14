import ClipboardJS from '../libs/clipboard';

// initiate clipboard.js on all buttons with class .btn-clipboard
const clipboard = new ClipboardJS('.btn-clipboard');

// show all clipboard buttons when the copy plugin is loaded
window.addEventListener('load', () => {
  document.querySelectorAll('.btn-clipboard').forEach(btn => {
    btn.classList.remove('invisible');
  })
});

// a little timeout to remove the focus from the button after copying
clipboard.on('success', (/** @type {{ clearSelection: () => void; }} */ event) => {
  setTimeout(() => {
    event.clearSelection()
  }, 500);
});

// handling errors
clipboard.on('error', (/** @type {any} */ event) => { });
