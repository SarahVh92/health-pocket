import { Controller } from "@hotwired/stimulus"



export default class extends Controller {
  static targets = ["qr-code-show"]
  revealContent() {
    // this.contentTarget.classList.remove("d-none")
    // console.log("click")
    document.querySelector(".qr-container").classList.remove("d-none")
  }
}
