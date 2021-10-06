<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .bigPictureWrapper { 
            position: absolute;
            display: none;
            justify-content: center;
            align-items: center;
            top: 0%;
            width: 100%;
            height: 100%;
            background-color: gray;
            z-index: 100;
            background: rgba(255, 255, 255, 0.5);
        }

        .bigPicture {
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .bigPicture img {
            width: 600px;
        }
    </style>
</head>

<body>
    <h1>이미지 크게보기</h1>
    <hr>
    <div class='bigPictureWrapper'><!-- 화면 확대했을때 -->
        <div class='bigPicture'></div><!-- 확대했을때 사진 위치 -->
    </div>
    <img src="https://item.kakaocdn.net/do/3645ad09cad16095e0c9674f4dc42bd1617ea012db208c18f6e83b1a90a7baa7"
        style="width: 200px; height: 200px;">
    <img src="https://seoul-p-studio.bunjang.net/product/81013324_1_1529667465_w640.jpg"
        style="width: 200px; height: 200px;">
    <img src="https://pbs.twimg.com/media/DTPgfyyUQAA4Qdv.jpg" style="width: 200px; height: 200px;">
</body>
<script type="text/javascript">
    $(document).ready(function (e) {//로딩되면 준비

        $(document).on("click", "img", function () {//img를 클릭하면 실행해라~
            var path = $(this).attr('src')//value속성 src를 path넣는다
            showImage(path);//메서드 실행해라~
        });//end click event

        function showImage(fileCallPath) {

            $(".bigPictureWrapper").css("display", "flex").show();//div요소에 css속성 주기

            $(".bigPicture")
                .html("<img src='" + fileCallPath + "' >")//사진을 화면에 띄운다
                //.animate({ width: '100%', height: '100%' }, 1000);

        }//end fileCallPath

        $(".bigPictureWrapper").on("click", function (e) {
            //$(".bigPicture").animate({ width: '0%', height: '0%' }, 1000);
            setTimeout(function () {
                $('.bigPictureWrapper').hide();
            }, 1);
        });//end bigWrapperClick event
    });
</script>