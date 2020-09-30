tocbot.init({
  tocSelector: '.js-toc',
  contentSelector: '.article-body',
  headingSelector: 'h1, h2, h3',
  positionFixedSelector: '.js-position-fixed',
  collapseDepth: 6, // disable collapse
  scrollSmooth: false,
  fixedSidebarOffset: document.querySelector('.js-position-fixed').offsetTop,
  headingsOffset: 50,
});
tocbot.refresh();
