import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  connect() {
    console.log("Reactions controller conectado")
  }

  toggle() {
    this.menuTarget.classList.toggle("hidden")
  }
}