# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin 'bootstrap', to: 'bootstrap.js', preload: true
pin '@popperjs/core', to: 'https://unpkg.com/@popperjs/core@2.11.5/dist/esm/index.js', preload: true # @2.11.5
pin 'masonry-layout', to: 'https://cdn.jsdelivr.net/npm/masonry-layout@4.2.2/dist/masonry.pkgd.min.js', preload: true # @4.2.2
