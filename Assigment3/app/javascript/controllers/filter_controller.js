import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "minPrice", "maxPrice", "rangeMin", "rangeMax", "sliderTrack"];

  connect() {
    this.submitTimeout = null;
    this.updateSliderTrack();
    this.rangeMinTarget.addEventListener('input', () => this.updateSliderTrack);
    this.rangeMaxTarget.addEventListener('input', () => this.updateSliderTrack);
  }
  submit() {
    this.updateSliderTrack();
    clearTimeout(this.submitTimeout);
    this.submitTimeout = setTimeout(() => {
      this.formTarget.requestSubmit();
    }, 300);
  }


  updateSliderTrack() {
    const minVal = parseInt(this.rangeMinTarget.value);
    const maxVal = parseInt(this.rangeMaxTarget.value);

    this.minPriceTarget.innerText = `${minVal}$`;
    this.maxPriceTarget.innerText = `${maxVal}$`;

    const percentMin = (minVal / parseInt(this.rangeMinTarget.max)) * 100;
    const percentMax = (maxVal / parseInt(this.rangeMaxTarget.max)) * 100;

    this.sliderTrackTarget.style.background = `linear-gradient(to right, rgb(199, 198, 198) ${percentMin}%, orange ${percentMin}%, orange ${percentMax}%, rgb(199, 198, 198) ${percentMax}%)`;
  }
}