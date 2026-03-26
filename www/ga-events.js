// ga-events.js

document.addEventListener('DOMContentLoaded', function () {
  
  // ---- custom shiny download tracking ----
  if (window.Shiny) {
    Shiny.addCustomMessageHandler('trackDownload', function (message) {
      if (typeof gtag === 'function') {
        gtag('event', 'file_download', {
          event_category: 'file',
          event_label: message.filename || 'shiny_download',
          transport_type: 'beacon'
        });
      }
    });
  } else {
    console.warn('Shiny not found: Shiny download tracking disabled');
  }
  
  // ---- Screenshot button click tracking ----
  document.addEventListener('click', function (e) {

    // Handles clicks on the button OR child elements (like the icon)
    const btn = e.target.closest('#screenshot_btn');

    if (btn) {
      if (typeof gtag === 'function') {
        gtag('event', 'file_download', {
          event_category: 'file',
          event_label: 'SO Data Viewer - screenshot_pdf_dwnld',
          transport_type: 'beacon'
        });
      }
    }

  });

});