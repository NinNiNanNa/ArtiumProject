(function($,window,document,undefined){

    var rvWrite = {

        init: function(){
            var that = this;
                that.rvWrite1Fn();

        },
        rvWrite1Fn : function(){
            /* 재업로드시 기존 업로드 파일 초기화 시켜줘야됌.... */
            var sel_files = [];

            // 파일업로드 미리보기
            $("#rvImgFile").on("change", function(event) {
            // 기존에 선택한 파일 초기화
             sel_files = [];
         
             // 미리보기 이미지 영역 초기화
             $(".uploadimg_wrap").empty();
                
                var files = event.target.files;
                var filesArr = Array.prototype.slice.call(files);
                
                filesArr.forEach(function(f) {
                    if(!f.type.match("image.*")){
                        alert("이미지만 업로드 가능합니다.");
                        return;
                    }
                    
                    sel_files.push(f);
                    
                    var reader = new FileReader(); 
                    reader.onload = function(e) {
                        var img_html = "<div class='uploadimg_box'><img src=\"" + e.target.result + "\" /></div>";
                        $(".uploadimg_wrap").append(img_html);
                    }
                    reader.readAsDataURL(f);
                });
                
            });
            
        }

    }
    rvWrite.init();

})(jQuery,window,document);