import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-trade-request-resource"
export default class extends Controller {
  add_resource(e){
    e.preventDefault();
    const{url}=e.target.dataset;
    this.element.src=url;
    console.log("ping")
  }
}
