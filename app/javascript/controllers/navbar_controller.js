import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "button","nav" ]

  toggle() {
    if(this.navTarget.classList.contains("hidden")) {
      this.navTarget.classList.toggle("hidden")
      this.buttonTarget.classList.remove("border-slate-500", "dark:border-slate-400", "text-slate-500", "dark:text-slate-400")
      this.buttonTarget.classList.add("border-sky-500", "dark:border-sky-400", "text-sky-500", "dark:text-sky-400")
    } else {
      this.navTarget.classList.toggle("hidden")
      this.buttonTarget.classList.remove("border-sky-500", "dark:border-sky-400", "text-sky-500", "dark:text-sky-400")
      this.buttonTarget.classList.add("border-slate-500", "dark:border-slate-400", "text-slate-500", "dark:text-slate-400")
    }
  }
}