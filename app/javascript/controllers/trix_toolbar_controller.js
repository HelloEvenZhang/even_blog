import { Controller } from "@hotwired/stimulus"

// 标题层级配置：单一数据源，新增/修改标题级别只需改这里
const HEADINGS = [
  { attribute: "heading1", label: "H1", title: "Heading 1" },
  { attribute: "heading2", label: "H2", title: "Heading 2" },
  { attribute: "heading3", label: "H3", title: "Heading 3" },
]

// heading1 是 Trix 内置属性；heading2/heading3 必须在 trix-editor 初始化前注册，
// 所以放在模块顶层立即执行（模块只加载一次，不会重复注册）。
;(function registerCustomHeadings() {
  const Trix = window.Trix
  if (!Trix) return
  Trix.config.blockAttributes.heading2 = { tagName: "h2", terminal: true, breakOnReturn: true, group: false }
  Trix.config.blockAttributes.heading3 = { tagName: "h3", terminal: true, breakOnReturn: true, group: false }
})()

export default class extends Controller {
  connect() {
    this._onTrixInit = ({ target }) => this._injectHeadingButtons(target.toolbarElement)
    this.element.addEventListener("trix-initialize", this._onTrixInit)

    // 处理 Lazy Load 场景：controller 连接时 trix-editor 可能已初始化完毕
    const editor = this.element.querySelector("trix-editor")
    if (editor?.toolbarElement) this._injectHeadingButtons(editor.toolbarElement)
  }

  disconnect() {
    this.element.removeEventListener("trix-initialize", this._onTrixInit)
  }

  _injectHeadingButtons(toolbar) {
    if (toolbar.dataset.headingsInjected) return
    const h1Button = toolbar.querySelector('[data-trix-attribute="heading1"]')
    if (!h1Button) return

    // 用 HEADINGS 统一创建所有按钮，replaceWith 一次性替换原有 h1 按钮
    const buttons = HEADINGS.map(({ attribute, label, title }) => {
      const btn = document.createElement("button")
      btn.type = "button"
      btn.className = "trix-button"
      btn.dataset.trixAttribute = attribute
      btn.title = title
      btn.innerHTML = `<span class="trix-heading-label">${label}</span>`
      return btn
    })

    h1Button.replaceWith(...buttons)
    toolbar.dataset.headingsInjected = "true"
  }
}
