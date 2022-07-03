// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

async function load() {
    try {
        await Promise.all([
            import('controllers'),
            // import "@popperjs/core"
            import('bootstrap'),
            // TODO: find a good way to defer running masonry until after image loading, while keeping it being triggerd by data-masonry
            import('masonry-layout'),
        ])
    } catch (e) {
        console.error('Failed to load a JS dependency', e)
    }
}

load()