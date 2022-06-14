import { Controller } from '@hotwired/stimulus'

function generatePlaceholder(modelYear, make, model) {
    if (modelYear === '') {
        modelYear = 'Unknown Year';
    }
    if (make === '') {
        make = 'Unknown Make';
    }
    if (model === '') {
        model = 'Unknown Model';
    }
    return `${modelYear} ${make} ${model}`;
}

export default class extends Controller {
    static targets = [ 'modelYear', 'make', 'model', 'displayName' ]

    update() {
        this.displayNameTarget.placeholder = generatePlaceholder(
            this.modelYearTarget.value.trim(),
            this.makeTarget.value.trim(),
            this.modelTarget.value.trim(),
        );
    }
}
