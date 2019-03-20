function checkEditSubject() {
    var name = document.getElementById("EditSubjectName").value;
    if (name === "") {
        var validator = document.getElementById("EditSubjectValidator");
        ValidatorEnable(validator);
        return false;
    }
    return true;
}

function checkEditSubjectPassword() {
    var name = document.getElementById("EditSubjectPassword").value;
    if (name === "") {
        var validator = document.getElementById("EditSubjectPasswordValidator");
        ValidatorEnable(validator);
        return false;
    }
    return true;
}

function checkChangeSubjectPassword() {
    var name = document.getElementById("ChangeSubjectPassword").value;
    if (name === "") {
        var validator = document.getElementById("ChangeSubjectPasswordValidator");
        ValidatorEnable(validator);
        return false;
    }
    return true;
}

function checkBlock() {
    var name = document.getElementById("BlockName").value;
    if (name === "") {
        var validator = document.getElementById("BlockValidator");
        ValidatorEnable(validator);
        return false;
    }
    return true;
}

function checkeditBlock() {
    var name = document.getElementById("EditBlockName").value;
    if (name === "") {
        var validator = document.getElementById("EditBlockValidator");
        ValidatorEnable(validator);
        return false;
    }
    return true;
}

function checkDownload() {

    var downloadName = document.getElementById("downloadResourceName").value;
    var downloadFile = document.getElementById("downloadResourceFile").value;
    var flag = true;
    var validator;
    if (downloadName === "") {
        validator = document.getElementById("downloadNameValidator");
        ValidatorEnable(validator);
        flag = false;
    }
    if (downloadFile === "") {
        validator = document.getElementById("downloadFileValidator");
        ValidatorEnable(validator);
        flag = false;
    }
    return flag;
}

function checkeditDownload() {

    var downloadName = document.getElementById("editDownloadResourceName").value;
    var downloadFile = document.getElementById("editDownloadResourceFile").value;
    var flag = true;
    var validator;
    if (downloadName === "") {
        validator = document.getElementById("editDownloadNameValidator");
        ValidatorEnable(validator);
        flag = false;
    }
    if (downloadFile === "") {
        validator = document.getElementById("editDownloadFileValidator");
        ValidatorEnable(validator);
        flag = false;
    }
    return flag;
}

function checkVideo() {

    var videoName = document.getElementById("videoResourceName").value;
    var videoPath = document.getElementById("videoPath").value;
    var flag = true;
    var validator;
    
    if (videoName === "") {
        validator = document.getElementById("videoResourceNameValidator");
        ValidatorEnable(validator);
        flag = false;
    }
    if (videoPath === "") {
        validator = document.getElementById("videoResourcePathValidator");
        ValidatorEnable(validator);
        flag = false;
    } else {
        var pattern = new RegExp("(https:\/\/)?www\.youtube\.com\/watch\?v=.*|https:\/\/www\.youtube\.com\/embed\/.*");
        if (pattern.test(videoPath)) {
            flag = false;
        }
    }
    
    return flag;
}

function checkEditVideo() {

    var videoName = document.getElementById("EditVideoResourceName").value;
    var videoPath = document.getElementById("EditVideoPath").value;
    var flag = true;
    var validator;

    if (videoName === "") {
        validator = document.getElementById("EditVideoResourceNameValidator");
        ValidatorEnable(validator);
        flag = false;
    }
    if (videoPath === "") {
        validator = document.getElementById("EditVideoResourcePathValidator");
        ValidatorEnable(validator);
        flag = false;
    } else {
        var pattern = new RegExp("(https:\/\/)?www\.youtube\.com\/watch\?v=.*|https:\/\/www\.youtube\.com\/embed\/.*");
        if (pattern.test(videoPath)) {
            flag = false;
        }
    }

    return flag;
}

function checkImage() {

    var imageFile = document.getElementById("imageResourceFile").value;
    var flag = true;

    if (imageFile === "") {
        var validator = document.getElementById("imageValidator");
        ValidatorEnable(validator);
        flag = false;
    } else {
        var pattern = new RegExp("^.+\.(jpg|JPG|png|PNG|gif|GIF)$");
        if (!pattern.test(imageFile)) {
            flag = false;
        }
    }
    return flag;
}

function checkEditImage() {

    var imageFile = document.getElementById("EditImageResourceFile").value;
    var flag = true;

    if (imageFile === "") {
        var validator = document.getElementById("EditImageValidator");
        ValidatorEnable(validator);
        flag = false;
    } else {
        var pattern = new RegExp("^.+\.(jpg|JPG|png|PNG|gif|GIF)$");
        if (!pattern.test(imageFile)) {
            flag = false;
        }
    }
    return flag;
}

function checkText() {
    var textResource = document.getElementById("textResource").value;
    
    if (textResource === "") {
        var validator = document.getElementById("textValidator");
        ValidatorEnable(validator);
        return false;
    }
    return true;
}

function checkTextEdit() {
    var textResource = document.getElementById("editTextResource").value;

    if (textResource === "") {
        var validator = document.getElementById("editTextValidator");
        ValidatorEnable(validator);
        return false;
    }
    return true;
}

function checkRiddle() {
    
    var riddleName = document.getElementById("riddleName").value;
    var riddleAudioFile = document.getElementById("riddleAudioFile").value;
    var riddleImageFile = document.getElementById("riddleImageFile").value;
    var riddleAnswer = document.getElementById("riddleAnswer").value;
    flag = true;
    var validator;
    if (riddleName === "") {
        
        validator = document.getElementById("riddleNameValidator");
        
        ValidatorEnable(validator);
        flag = false;
        
    }
    
    if (riddleAudioFile === "") {
       validator = document.getElementById("AudioFileValidator");
        ValidatorEnable(validator);
        flag = false;
    } else {
        var pattern = new RegExp("^.+\.(mp3|MP3)$");
        if (!pattern.test(riddleAudioFile)) {
            flag = false;
        }
    }
    
    if (riddleImageFile !== "") {
        var pattern = new RegExp("^.+\.(jpg|JPG|png|PNG|gif|GIF)$");
        if (!pattern.test(riddleImageFile)) {
            flag = false;
        }

    }
    if (riddleAnswer === "") {

        validator = document.getElementById("riddleAnswerValidator");
        ValidatorEnable(validator);
        flag = false;
    }
    return flag;
}

function checkEditRiddle() {

    var riddleName = document.getElementById("EditRiddleName").value;
    var riddleAudioFile = document.getElementById("EditRiddleAudioFile").value;
    var riddleImageFile = document.getElementById("EditRiddleImageFile").value;
    var riddleAnswer = document.getElementById("EditRiddleAnswer").value;
    flag = true;
    var validator;
    if (riddleName === "") {

        validator = document.getElementById("EditRiddleNameValidator");

        ValidatorEnable(validator);
        flag = false;

    }

    if (riddleAudioFile === "") {
        validator = document.getElementById("EditRiddleAudioValidator");
        ValidatorEnable(validator);
        flag = false;
    } else {
        var pattern = new RegExp("^.+\.(mp3|MP3)$");
        if (!pattern.test(riddleAudioFile)) {
            flag = false;
        }
    }

    if (riddleImageFile !== "") {
        var pattern = new RegExp("^.+\.(jpg|JPG|png|PNG|gif|GIF)$");
        if (!pattern.test(riddleImageFile)) {
            flag = false;
        }

    }
    if (riddleAnswer === "") {

        validator = document.getElementById("EditRiddleAnswerValidator");
        ValidatorEnable(validator);
        flag = false;
    }
    return flag;
}

function checkTask() {
    
    var taskName = document.getElementById("taskName").value;
    var taskText = document.getElementById("taskText").value;
    var taskDate = document.getElementById("taskDate").value;
    var flag = true;
    var validator;
    if (taskName === "") {
        validator = document.getElementById("taskNameValidator");
        ValidatorEnable(validator);
        flag = false;
    }
    if (taskText === "") {
        validator = document.getElementById("taskTextValidator");
        ValidatorEnable(validator);
        flag = false;
    }
    if (taskDate === "") {
        validator = document.getElementById("taskDateValidator");
        ValidatorEnable(validator);
        flag = false;
    }
    return flag;
}

function checkEditTask() {

    var taskName = document.getElementById("EditTaskName").value;
    var taskText = document.getElementById("EditTaskText").value;
    var taskDate = document.getElementById("taskDate").value;
    var flag = true;
    var validator;
    if (taskName === "") {
        validator = document.getElementById("EditTaskNameValidator");
        ValidatorEnable(validator);
        flag = false;
    }
    if (taskText === "") {
        validator = document.getElementById("EditTaskTextValidator");
        ValidatorEnable(validator);
        flag = false;
    }
    if (taskDate === "") {
        validator = document.getElementById("EditTaskDateValidator");
        ValidatorEnable(validator);
        flag = false;
    }
    return flag;
}

function checkProfileImage() {

    var imageFile = document.getElementById("Image").value;
    var flag = true;

    if (imageFile !== "") {
        
        var pattern = new RegExp("^.+\.(jpg|JPG|png|PNG|gif|GIF)$");
        if (!pattern.test(imageFile)) {
            flag = false;
        }
    }
    return flag;
}

function checkEditUser() {

    var taskName = document.getElementById("EditUserName").value;
    var taskText = document.getElementById("EditSurname1").value;
    var flag = true;
    var validator;
    if (taskName === "") {
        validator = document.getElementById("EditUserValidator");
        ValidatorEnable(validator);
        flag = false;
    }
    if (taskText === "") {
        validator = document.getElementById("EditSurname1Validator");
        ValidatorEnable(validator);
        flag = false;
    }
    return flag;
}

function changeVisibility(id) {
    alert(id);
    $.ajax({
        type: "POST",
        url: "Subject.aspx/ChangeVisibility",
        data: '{id: "' + id + '" }',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function comeBack() {
            return false;
        }
    })
}



/*
    if (riddleOGText === "") {
    <asp:RequiredFieldValidator runat="server" ControlToValidate="OGText" ClientIDMode="Static" ID="RiddleOGTextValidator"
                                            CssClass="text-danger" ErrorMessage="La transcripción es obligatoria." />
        validator = document.getElementById("RiddleOGTextValidator");
        ValidatorEnable(validator);
        flag = false;
    }
    if (riddleTransText === "") {
    <asp:RequiredFieldValidator runat="server" ControlToValidate="TransText" ClientIDMode="Static" ID="RiddleTransValidator"
                                            CssClass="text-danger" ErrorMessage="La traducción es obligatoria." />
        validator = document.getElementById("RiddleTransValidator");
        ValidatorEnable(validator);
        flag = false;
    }*/
 /*<asp: RequiredFieldValidator runat="server" ControlToValidate="riddleImageFile" ClientIDMode="Static" ID="RiddleImageValidator"
            CssClass="text-danger" ErrorMessage="La imagen es obligatoria." />*/