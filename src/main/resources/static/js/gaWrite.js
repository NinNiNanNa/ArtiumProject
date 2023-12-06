(function($,window,document,undefined){

    var gaWrite = {

        init: function(){
            var that = this;
                that.artImgFn();

        },
        artImgFn : function(){

            // 파일업로드 미리보기
            for (var i = 1; i <= 10; i++) {
                setupImagePreview("#artImgFile" + i, "#preview" + i);
            }
            
            function setupImagePreview(inputId, previewId) {
                $(inputId).on("change", function(event) {
                    var file = event.target.files[0];
                    var reader = new FileReader(); 
                    reader.onload = function(e) {
                        $(previewId).css("display", "block").attr("src", e.target.result);
                    }
                    reader.readAsDataURL(file);
                });
            }


        }

    }
    gaWrite.init();

})(jQuery,window,document);