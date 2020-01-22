document.addEventListener("DOMContentLoaded", function (event) {
    safari.extension.dispatchMessage("Page Loaded", {
        "numberOfAds": document.querySelectorAll('.ads-ad').length
    });
});

safari.self.addEventListener("message", function (event) {
    if (event.name == "refresh") {
        var state = event.message;

        [].forEach.call(document.querySelectorAll('.ads-ad'), function (el) {
            if (state.enabled) {
                el.classList.add('ad-background');
                el.classList.add('ad-title');
            } else {
                el.classList.remove('ad-background');
                el.classList.remove('ad-title');
            }
            el.style.display = state.display;
            el.style.backgroundColor = state.backgroundColor;
        });
    }
});
