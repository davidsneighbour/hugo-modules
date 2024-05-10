const observer = new PerformanceObserver((list) => {
  console.log(list.getEntries());
});

observer.observe({ type: "long-animation-frame", buffered: true });

const loafs = performance.getEntriesByType("long-animation-frame");
console.log(loafs);

// https://developer.mozilla.org/en-US/docs/Web/API/Performance_API/Long_animation_frame_timing
