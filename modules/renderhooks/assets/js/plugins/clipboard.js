import ClipboardJS from '../libs/clipboard/clipboard';

const clipboard = new ClipboardJS('.btn-clipboard');

// window.addEventListener('load', () => {
//   document.querySelectorAll('.btn-clipboard').forEach(btn => {
//     btn.classList.remove('invisible');
//   })
// });

clipboard.on('success', event => {

  setTimeout(() => {
    event.clearSelection()
  }, 500);

});

clipboard.on('error', event => { });
