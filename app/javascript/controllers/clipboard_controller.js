// app/javascript/controllers/clipboard_controller.js
import { Controller } from "@hotwired/stimulus"

// Se conecta al data-controller="clipboard" que añadimos en la vista
export default class extends Controller {
  // Define el 'target' que es el campo de texto con la URL
  static targets = [ "source" ]

  // Esta función se ejecuta cuando se hace clic en el botón (data-action="clipboard#copy")
  copy(event) {
    event.preventDefault() // Evita que el botón envíe un formulario

    // Selecciona el texto dentro del campo 'source' y lo copia al portapapeles
    navigator.clipboard.writeText(this.sourceTarget.value)

    // Opcional: Cambia el texto del botón para dar feedback al usuario
    const originalText = event.currentTarget.innerHTML
    event.currentTarget.innerHTML = "¡Copiado!"
    setTimeout(() => {
      event.currentTarget.innerHTML = originalText
    }, 2000) // Vuelve al texto original después de 2 segundos
  }
}
