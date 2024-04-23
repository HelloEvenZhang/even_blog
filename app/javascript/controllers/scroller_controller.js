import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  scroll(event) {
    location.href = event.params.to;
  }
}