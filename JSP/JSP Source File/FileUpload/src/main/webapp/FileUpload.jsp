<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>File Upload</title>
	<style>
		* {
		    box-sizing:border-box;
		    padding:0;
		    margin:0;
		}
		
		.wrapper {
		    width:100%;
		    margin-top:30px;
		    display:flex;
		    flex-direction:row;
		    justify-content:center;
		    align-items:center;
		}
		
		.upload_title {
		    padding:20px;
		}
		.upload_form {
		    border:3px solid gray;
		    width:30%;
		    height:300px;
		    border-radius:10%;
		    
		    display:flex;
		    flex-direction:column;
		    justify-content:center;
		    align-items:center;
		}
		
		.upload_title {
		    text-align:center;
		    margin-bottom:10px;
		}
		
		.upload_name {
		    font-size:20px;
		    font-weight:600;
		}
		
		.upload_id, .upload_file {
		    width:100%;
		    padding:5px;
		    margin:10px 0;
		
		    display:flex;
		    flex-direction:row;
		    justify-content:center;
		    align-items:center;
		
		    font-size:13px;
		    font-weight:600;
		}
		
		.upload_id_input_text {
		    width:70%;
		    margin-left:10px;
		    border-radius:10%;
		    border:2px solid gray;
		}
		
		.upload_file_input_text {
		    width:70%;
		    margin-left:10px;
		    border-radius:10%;
		}
		
		.upload_file_input_text::file-selector-button {
		    width:40%;
		    height:20px;
		    font-size:10px;
		    font-weight:600;
		}
		
		.menu_bar {
		    display:flex;
		    flex-direction:row;
		    justify-content:center;
		    align-items:center;
		    margin:10px;
		}
		
		.upload_button, .upload_cancel {
		    width:50px;
		    height:20px;
		    font-size:13px;
		    font-weight:600;
		    margin:10px;
		}
	</style>
</head>

<body>
   <div class="wrapper">
	<div class="upload_form">
        <form action="FileUploadProc.jsp" method="post" enctype ="multipart/form-data">
            <div class="upload_title"><p class="upload_name">파일 업로드</p></div>
            <div class="upload_id">
                <div class="upload_id_name"><p>ID : </p></div>
                <div class="upload_id_input"><input type="text" name="name" class="upload_id_input_text"></div>
            </div>


            <div class="upload_file">
                <p class="upload_file_name"><p>파일 : </p>
                <input type="file" name="filedata", class="upload_file_input_text">
            </div>

            <div class="menu_bar">
                <input type="submit" class="upload_button" value = "Upload">
                <input type="reset" class="upload_cancel" value = "Cancel">
            </div>
        </form>
    </div>
    </div>
</body>
</html>