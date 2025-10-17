// app/javascript/controllers/tabs_controller.js
import { Controller } from "@hotwired/stimulus"

// Este controlador se conectará al HTML que tenga data-controller="tabs"
export default class extends Controller {
  // Define los 'targets': los elementos que este controlador necesita encontrar.
  // Necesitamos las pestañas (tab) y los paneles de contenido (panel).
  static targets = ["tab", "panel"]

  // 'connect' es una función especial que se ejecuta cuando el controlador se carga.
  connect() {
    // Al cargar la página, nos aseguramos de que la primera pestaña esté activa por defecto.
    this.showTab(this.tabTargets[0])
  }

  // Esta función se ejecuta cuando el usuario hace clic en una pestaña (gracias a data-action).
  switch(event) {
    // Prevenimos el comportamiento por defecto del enlace (que es saltar al ancla #).
    event.preventDefault()
    // Llamamos a la función principal para mostrar la pestaña correcta.
    this.showTab(event.currentTarget)
  }

  // Esta es la función principal que oculta todo y luego muestra solo lo seleccionado.
  showTab(selectedTab) {
    // 1. Ocultamos todos los paneles y desactivamos todas las pestañas.
    this.panelTargets.forEach(panel => panel.classList.add("hidden"))
    this.tabTargets.forEach(tab => {
      tab.classList.remove("border-indigo-500", "text-indigo-600")
      tab.classList.add("border-transparent", "text-gray-500")
    })

    // 2. Mostramos el panel correcto y activamos la pestaña en la que se hizo clic.
    const targetPanelId = selectedTab.getAttribute("href").substring(1)
    document.getElementById(targetPanelId).classList.remove("hidden")
    selectedTab.classList.add("border-indigo-500", "text-indigo-600")
    selectedTab.classList.remove("border-transparent", "text-gray-500")
  }
}
