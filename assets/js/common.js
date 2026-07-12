$(document).ready(function () {
  // add toggle functionality to abstract, award and bibtex buttons
  function closeAward($entry) {
    $entry.find(".award.hidden.open").removeClass("open");
    $entry.find("button.award[aria-expanded='true']").attr("aria-expanded", "false");
  }

  function closeAbstract($entry) {
    $entry.find(".abstract.hidden.open").removeClass("open");
    $entry.find("a.abstract[aria-expanded='true']").attr("aria-expanded", "false");
  }

  function closeBibtex($entry) {
    $entry.find(".bibtex.hidden.open").removeClass("open");
    $entry.find("a.bibtex[aria-expanded='true']").attr("aria-expanded", "false");
  }

  $("a.abstract").click(function () {
    const $entry = $(this).parent().parent();
    const willOpen = !$entry.find(".abstract.hidden").hasClass("open");
    $entry.find(".abstract.hidden").toggleClass("open", willOpen);
    $(this).attr("aria-expanded", willOpen ? "true" : "false");
    closeAward($entry);
    closeBibtex($entry);
  });
  $("button.award").click(function () {
    const $entry = $(this).parent().parent();
    const willOpen = !$entry.find(".award.hidden").hasClass("open");
    closeAbstract($entry);
    closeBibtex($entry);
    $entry.find(".award.hidden").toggleClass("open", willOpen);
    $(this).attr("aria-expanded", willOpen ? "true" : "false");
  });
  $("a.bibtex").click(function () {
    const $entry = $(this).parent().parent();
    const willOpen = !$entry.find(".bibtex.hidden").hasClass("open");
    closeAbstract($entry);
    closeAward($entry);
    $entry.find(".bibtex.hidden").toggleClass("open", willOpen);
    $(this).attr("aria-expanded", willOpen ? "true" : "false");
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
