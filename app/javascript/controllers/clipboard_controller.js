import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["source", "button", "tooltip"]

  copy() {
    // Copy text to clipboard
    navigator.clipboard.writeText(this.sourceTarget.value)
      .then(() => {
        // Show tooltip
        this.tooltipTarget.style.opacity = "1"
        
        // Hide tooltip after 2 seconds
        setTimeout(() => {
          this.tooltipTarget.style.opacity = "0"
        }, 2000)
      })
      .catch(err => {
        console.error('Failed to copy text: ', err)
      })
  }
}
