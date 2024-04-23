import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  choose_dark() {
    localStorage.theme = 'dark'
    document.documentElement.classList.add('dark')
  }
  choose_light() {
    localStorage.theme = 'light'
    document.documentElement.classList.remove('dark')
  }
}