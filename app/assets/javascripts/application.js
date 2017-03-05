// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require froala_editor.min.js
//= require_tree .



$(document).ready(function() {

  $('.wysiwyg').froalaEditor();

	$(".js-example-data-ajax").select2({
      width: '100%',
      placeholder: "Search Recipes",
      ajax: {
        url: "http://localhost:8000/api/v1/main_search",
        dataType: 'json',
        delay: 250,
        data: function (params) {
          return {
            key: params.term, // search term
            page: params.page
          };
        },
        processResults: function (data, params) {
          // parse the results into the format expected by Select2
          // since we are using custom formatting functions we do not need to
          // alter the remote JSON data, except to indicate that infinite
          // scrolling can be used
          params.page = params.page || 1;

          return {
            results: data.keys,
            pagination: {
              more: (params.page * 30) < data.total_count
            }
          };
        },
        cache: true
      },
      escapeMarkup: function (markup) { return markup; }, // let our custom formatter work
      minimumInputLength: 1,
      templateResult: formatRepoOther, // omitted for brevity, see the source of this page
      templateSelection: formatRepoSelectionOther // omitted for brevity, see the source of this page
    });



    function formatRepoOther (key) {
      return key.name
    }


    function formatRepoSelectionOther (key) {
      window.open("http://localhost:8000/keys/" + key.name ,"_self");
      if (key.name == "Add new keyword") {
        return key.new_value;
      }else {
        return key.text;
      }
    }



});

