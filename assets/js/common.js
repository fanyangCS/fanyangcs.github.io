$(document).ready(function () {
  // add toggle functionality to abstract, award and bibtex buttons
  function closeAward($entry) {
    $entry.find(".award.hidden.open").removeClass("open");
    $entry.find("button.award[aria-expanded='true']").attr("aria-expanded", "false");
  }

  $("a.abstract").click(function () {
    const $entry = $(this).parent().parent();
    $entry.find(".abstract.hidden").toggleClass("open");
    closeAward($entry);
    $entry.find(".bibtex.hidden.open").removeClass("open");
  });
  $("button.award").click(function () {
    const $entry = $(this).parent().parent();
    const willOpen = !$entry.find(".award.hidden").hasClass("open");
    $entry.find(".abstract.hidden.open, .bibtex.hidden.open").removeClass("open");
    $entry.find(".award.hidden").toggleClass("open", willOpen);
    $(this).attr("aria-expanded", willOpen ? "true" : "false");
  });
  $("a.bibtex").click(function () {
    const $entry = $(this).parent().parent();
    $entry.find(".abstract.hidden.open").removeClass("open");
    closeAward($entry);
    $entry.find(".bibtex.hidden").toggleClass("open");
  });
  $("a").removeClass("waves-effect waves-light");

  // bootstrap-toc
  if ($("#toc-sidebar").length) {
    // remove related publications years from the TOC
    $(".publications h2").each(function () {
      $(this).attr("data-toc-skip", "");
    });
    var navSelector = "#toc-sidebar";
    var $myNav = $(navSelector);
    Toc.init($myNav);
    $("body").scrollspy({
      target: navSelector,
    });
  }

  // add css to jupyter notebooks
  const cssLink = document.createElement("link");
  cssLink.href = "../css/jupyter.css";
  cssLink.rel = "stylesheet";
  cssLink.type = "text/css";

  let jupyterTheme = determineComputedTheme();

  $(".jupyter-notebook-iframe-container iframe").each(function () {
    $(this).contents().find("head").append(cssLink);

    if (jupyterTheme == "dark") {
      $(this).bind("load", function () {
        $(this).contents().find("body").attr({
          "data-jp-theme-light": "false",
          "data-jp-theme-name": "JupyterLab Dark",
        });
      });
    }
  });

  // trigger popovers
  $('[data-toggle="popover"]').popover({
    trigger: "hover",
  });
});
