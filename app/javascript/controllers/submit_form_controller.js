import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="submit-form"
export default class extends Controller {
  connect() {
  }
  send(event) {
    event.currentTarget.submit()
  }
}
