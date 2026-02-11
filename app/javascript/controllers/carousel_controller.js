import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container", "dot"]

  connect() {
    this.currentIndex = 0
    this.updateDots()

    // Listen to scroll events to update dots when user swipes
    this.containerTarget.addEventListener("scroll", this.handleScroll.bind(this))
  }

  disconnect() {
    this.containerTarget.removeEventListener("scroll", this.handleScroll.bind(this))
  }

  handleScroll() {
    // Debounce the scroll event
    clearTimeout(this.scrollTimeout)
    this.scrollTimeout = setTimeout(() => {
      const container = this.containerTarget
      const scrollLeft = container.scrollLeft
      const itemWidth = container.offsetWidth
      const newIndex = Math.round(scrollLeft / itemWidth)

      if (newIndex !== this.currentIndex) {
        this.currentIndex = newIndex
        this.updateDots()
      }
    }, 50)
  }

  next() {
    const totalItems = this.dotTargets.length
    this.currentIndex = (this.currentIndex + 1) % totalItems
    this.scrollToIndex(this.currentIndex)
  }

  prev() {
    const totalItems = this.dotTargets.length
    this.currentIndex = (this.currentIndex - 1 + totalItems) % totalItems
    this.scrollToIndex(this.currentIndex)
  }

  scrollToIndex(index) {
    const container = this.containerTarget
    const itemWidth = container.offsetWidth
    container.scrollTo({
      left: itemWidth * index,
      behavior: "smooth"
    })
    this.updateDots()
  }

  updateDots() {
    this.dotTargets.forEach((dot, index) => {
      if (index === this.currentIndex) {
        dot.classList.remove("bg-white/60")
        dot.classList.add("bg-white")
      } else {
        dot.classList.remove("bg-white")
        dot.classList.add("bg-white/60")
      }
    })
  }
}
