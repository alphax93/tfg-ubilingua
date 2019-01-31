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
        var pattern = new RegExp("https:\/\/www\.youtube\.com\/watch\?v=\w*|https:\/\/www\.youtube\.com\/embed\/\w*");
        if (!pattern.test(videoPath)) {
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

function checkText() {
    var textResource = document.getElementById("textResource").value;
    
    if (textResource === "") {
        var validator = document.getElementById("textValidator");
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

function changeVisibility(id) {
    $.ajax({
        type: "POST",
        url: "Subject.aspx/ChangeVisibility",
        data: '{id: "' + id + '" }',
        contentType: "application/json; charset=utf-8",
        dataType: "json"
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