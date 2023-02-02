import { Controller } from "@hotwired/stimulus"
im
export default class extends Controller {
  connect() {
    this.element.textContent = "Hello World!"
  }
}
