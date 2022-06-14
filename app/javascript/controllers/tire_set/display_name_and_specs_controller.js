import { Controller } from '@hotwired/stimulus'

function maybe(x) {
    if (x === null || x === '' || x === 0) {
        return '?';
    } else {
        return `${x}`;
    }
}

function generateSpecs(vehicleType, width, aspectRatio, construction, diameter, loadIndex, speedRating) {
    return `${maybe(vehicleType)}${maybe(width)}/${maybe(aspectRatio)}${maybe(construction)}${maybe(diameter)} ${maybe(loadIndex)}${maybe(speedRating)}`
}

function generatePlaceholder(make, model, specs) {
    if (make === '') {
        make = 'Unknown Make';
    }
    if (model === '') {
        model = 'Unknown Model';
    }
    return `${make} ${model} (${specs})`;
}

function tryParseInt(x) {
    const int = parseInt(x, 10);
    if (isNaN(int)) {
        return null;
    } else {
        return int;
    }
}

function ensureOnlyNumbersInValue(el) {
    el.value = el.value.replace(/[^0-9]/g, '');
}

export default class extends Controller {
    static targets = [ 'make', 'model', 'vehicleType', 'width', 'aspectRatio', 'construction', 'diameter', 'loadIndex', 'speedRating', 'specs', 'displayName' ]

    update() {
        ensureOnlyNumbersInValue(this.widthTarget);
        ensureOnlyNumbersInValue(this.aspectRatioTarget);
        ensureOnlyNumbersInValue(this.diameterTarget);
        ensureOnlyNumbersInValue(this.loadIndexTarget);
        const make = this.makeTarget.value.trim();
        const model = this.modelTarget.value.trim();
        const vehicleType = this.vehicleTypeTarget.value.trim();
        const width = tryParseInt(this.widthTarget.value.trim());
        const aspectRatio = tryParseInt(this.aspectRatioTarget.value.trim());
        const construction = this.constructionTarget.value.trim();
        const diameter = tryParseInt(this.diameterTarget.value.trim());
        const loadIndex = tryParseInt(this.loadIndexTarget.value.trim());
        const speedRating = this.speedRatingTarget.value.trim();
        const specs = generateSpecs(vehicleType, width, aspectRatio, construction, diameter, loadIndex, speedRating);
        for (const specsTarget of this.specsTargets) {
            specsTarget.innerHTML = specs;
        }
        this.displayNameTarget.placeholder = generatePlaceholder(make, model, specs);
    }
}
