document.addEventListener("DOMContentLoaded", () => {
  // --- Slider ---
  const slides = [
    "/images/slider/slide1.png",
    "/images/slider/slide2.png",
    "/images/slider/slide3.png",
    "/images/slider/slide4.png",
    "/images/slider/slide5.png",
    "/images/slider/slide6.png",
    "/images/slider/slide7.png"
  ];
  let idx = 0;
  const slider = document.getElementById("slider");

  if (slider) {
    setInterval(() => {
      idx = (idx + 1) % slides.length;
      slider.src = slides[idx];
    }, 3000);
  }

  // --- Carousel Logic (Deals + Trending) ---
  let dealsIndex = 0;
  let trendingIndex = 0;

  function scrollCarousel(rowId, index, cardsPerPage = 2) {
    const row = document.getElementById(rowId);
    if (!row) return 0;

    const cards = row.querySelectorAll(".deal-card");
    if (!cards.length) return 0;

    const totalPages = Math.ceil(cards.length / cardsPerPage);

    // Bound the index so it never goes out of range
    if (index < 0) index = 0;
    if (index >= totalPages) index = totalPages - 1;

    // Shift the row by percentage
    const shift = -(index * 100);
    row.style.transform = `translateX(${shift}%)`;

    return index;
  }

  // Expose global functions for buttons
  window.scrollDeals = function (direction) {
    dealsIndex += direction;
    dealsIndex = scrollCarousel("dealsRow", dealsIndex, 2);
  };

  window.scrollTrending = function (direction) {
    trendingIndex += direction;
    trendingIndex = scrollCarousel("trendingRow", trendingIndex, 2);
  };
});
