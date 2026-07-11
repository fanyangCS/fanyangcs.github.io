const assert = require("node:assert/strict");
const fs = require("node:fs");
const test = require("node:test");
const vm = require("node:vm");

const themeScript = fs.readFileSync("assets/js/theme.js", "utf8");

function loadTheme({ hasToggle = false, prefersDark = false } = {}) {
  const attributes = new Map();
  const storage = new Map();
  const listeners = {};
  const mediaListeners = {};
  const highlights = {
    highlight_theme_dark: {},
    highlight_theme_light: {},
  };
  const toggle = hasToggle
    ? {
        addEventListener(type, listener) {
          listeners[type] = listener;
        },
      }
    : null;

  const document = {
    documentElement: {
      classList: { add() {}, remove() {} },
      setAttribute(name, value) {
        attributes.set(name, value);
      },
    },
    addEventListener(type, listener) {
      listeners[type] = listener;
    },
    getElementById(id) {
      return id === "light-toggle" ? toggle : highlights[id];
    },
    getElementsByTagName() {
      return [];
    },
    getElementsByClassName() {
      return [];
    },
    querySelector() {
      return null;
    },
  };
  const localStorage = {
    getItem(key) {
      return storage.has(key) ? storage.get(key) : null;
    },
    setItem(key, value) {
      storage.set(key, value);
    },
  };
  const mediaQuery = {
    get matches() {
      return prefersDark;
    },
    addEventListener(type, listener) {
      mediaListeners[type] = listener;
    },
  };
  const context = {
    document,
    localStorage,
    window: {
      matchMedia() {
        return mediaQuery;
      },
      setTimeout() {},
    },
  };

  vm.runInNewContext(`${themeScript}\ninitTheme();`, context);
  return { attributes, listeners, mediaListeners, storage };
}

test("theme initialization is safe without a toggle control", () => {
  const page = loadTheme();

  assert.doesNotThrow(() => page.listeners.DOMContentLoaded());
  assert.equal(page.attributes.get("data-theme-setting"), "system");
  assert.equal(page.attributes.get("data-theme"), "light");
});

test("theme toggle still cycles light, dark, and system", () => {
  const page = loadTheme({ hasToggle: true });
  page.listeners.DOMContentLoaded();

  page.listeners.click();
  assert.equal(page.storage.get("theme"), "light");
  assert.equal(page.attributes.get("data-theme"), "light");

  page.listeners.click();
  assert.equal(page.storage.get("theme"), "dark");
  assert.equal(page.attributes.get("data-theme"), "dark");

  page.listeners.click();
  assert.equal(page.storage.get("theme"), "system");
  assert.equal(page.attributes.get("data-theme"), "light");
});

test("system preference initializes and reapplies the computed theme", () => {
  const page = loadTheme({ prefersDark: true });

  assert.equal(page.attributes.get("data-theme"), "dark");
  assert.doesNotThrow(() => page.mediaListeners.change({ matches: false }));
  assert.equal(page.attributes.get("data-theme"), "dark");
});
