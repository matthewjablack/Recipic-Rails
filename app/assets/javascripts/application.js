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

  var coinamount = 8000;

  $('.coinages').html(coinamount);

  $('.coinbutton').click(function() {
    coinamount -= 100;
    $('.coinages').html(coinamount);
  })

  var api_key = $('body').attr('class');

  $(".itemSearch").select2({
      tags: true,
      multiple: true,
      tokenSeparators: [',', ' '],
      minimumInputLength: 2,
      minimumResultsForSearch: 10,
      ajax: {
          url: "/api/v1/items?auth_token=" + api_key,
          dataType: "json",
          type: "GET",
          data: function (params) {

              var queryParameters = {
                  term: params.term
              }
              return queryParameters;
          },
          processResults: function (data) {
            console.log(data);
              return {
                  results: $.map(data, function (item) {
                    console.log("info 1");
                    console.log(item);
                      return {
                          text: item[0].name,
                          id: item[0].id
                      }
                  })
              };
          }
      }
  });


  // $(".itemSearch").select2({
  //   width: '100%',
  //   placeholder: "Search Keywords",
  //   ajax: {
  //   url: "/api/v1/items?auth_token=god-LC5Vn8yrnsxYGDco",
  //   dataType: 'json',
  //   delay: 250,
  //   data: function (params) {
  //     return {
  //     key: params.term, // search term
  //     page: params.page
  //     };
  //   },
  //   processResults: function (data, params) {
  //     // parse the results into the format expected by Select2
  //     // since we are using custom formatting functions we do not need to
  //     // alter the remote JSON data, except to indicate that infinite
  //     // scrolling can be used
  //     console.log(data);
  //     params.page = params.page || 1;

  //     return {
  //     results: data.keys,
  //     pagination: {
  //       more: (params.page * 30) < data.total_count
  //     }
  //     };
  //   },
  //   cache: true
  //   },
  //   escapeMarkup: function (markup) { return markup; }, // let our custom formatter work
  //   minimumInputLength: 1,
  //   templateResult: formatKey, // omitted for brevity, see the source of this page
  //   templateSelection: formatKeySelection // omitted for brevity, see the source of this page

  // });

  // function formatKey (key) {
  //     return key.name
  //   }


  // function formatKeySelection (key) {
  // console.log(key);

  //   if (key.name == "Add new keyword") {
  //     return key.new_value;
  //   }else {
  //     return key.text;
  //   }

  // }





  //
  // $(".itemSearch").select2({
  //     tags: true,
  //     multiple: true,
  //     tokenSeparators: [',', ' '],
  //     minimumInputLength: 2,
  //     minimumResultsForSearch: 10,
  //     ajax: {
  //         url: "/api/v1/items?auth_token=XP9CPE4eEPJW3s2sb89f",
  //         dataType: "json",
  //         type: "GET",
  //         results: function(data, page) {
  //         return {
  //           results: $.map( data, function(person, i) {
  //             return { id: item.id, text: item.name }
  //           } )
  //         }
  //       }
  //       }
  //     }
  // });



	// $(".itemSearch").select2({
 //      width: '100%',
 //      placeholder: "Search Recipes",
 //      ajax: {
 //        url: "http://localhost:8000/api/v1/main_search",
 //        dataType: 'json',
 //        delay: 250,
 //        data: function (params) {
 //          return {
 //            key: params.term, // search term
 //            page: params.page
 //          };
 //        },
 //        processResults: function (data, params) {
 //          // parse the results into the format expected by Select2
 //          // since we are using custom formatting functions we do not need to
 //          // alter the remote JSON data, except to indicate that infinite
 //          // scrolling can be used
 //          params.page = params.page || 1;

 //          return {
 //            results: data.keys,
 //            pagination: {
 //              more: (params.page * 30) < data.total_count
 //            }
 //          };
 //        },
 //        cache: true
 //      },
 //      escapeMarkup: function (markup) { return markup; }, // let our custom formatter work
 //      minimumInputLength: 1,
 //      templateResult: formatRepoOther, // omitted for brevity, see the source of this page
 //      templateSelection: formatRepoSelectionOther // omitted for brevity, see the source of this page
 //    });



 //    function formatRepoOther (key) {
 //      return key.name
 //    }


 //    function formatRepoSelectionOther (key) {
 //      window.open("http://localhost:8000/keys/" + key.name ,"_self");
 //      if (key.name == "Add new keyword") {
 //        return key.new_value;
 //      }else {
 //        return key.text;
 //      }
 //    }



});
