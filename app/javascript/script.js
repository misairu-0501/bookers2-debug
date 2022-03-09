// let title = "javascriptが使えました";
// alert(title);

$(document).on('turbolinks:load', function () {
  $('#evaluate_stars').raty({
    // starOn: "<%= asset_path('star-on.png') %>",
    // starOff: "<%= asset_path('star-off.png') %>",
    // starHalf: "<%= asset_path('star-half.png') %>",
    path: '/assets/',
    scoreName: 'book[evaluation]', //登録するモデル名とカラム名を記述
    half: true
  });
});

$(document).on('turbolinks:load', function () {
  $('.book-evaluation').raty({
    readOnly: true,
    score: function() {
      return $(this).attr('data-score');
    },
    path: '/assets/'
  });
});
