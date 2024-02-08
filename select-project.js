const Virus = ["virusCommonName", "Genus", "Status", "TransmissionType"];
const Vaccine = ["Type", "Manufacture", "DeliveryMode", "Year"];
const Disease = ["diseaseName", "diseaseType"];
const op = [">", ">", "=", ">=", "<=", "AND", "OR", "<>"];

function selectFunc() {
    document.getElementById('condDiv').innerHTML = "";
    let condNum = document.getElementById('CondiCount').value;
    let tabChoice = document.getElementById('selectTab').value;
    let tab;
    if (condNum <= 0) return;

    if (tabChoice === 'Virus3') {
        tab = Virus;
    } else if (tabChoice === 'VaccineAgainst2') {
        tab = Vaccine;
    } else if (tabChoice === 'ViralDisease') {
        tab = Disease;
    }

    let opDropDown = document.createElement('select');
    opDropDown.name = 'op';
    opDropDown.id = 'op';
    for (let i = 0; i < op.length; i++) {
        let option = document.createElement('option');
        option.values = op[i];
        option.text = op[i];
        opDropDown.appendChild(option);
    }

    let attrDropDown = document.createElement("select");
    attrDropDown.name = 'attrDropDown';
    attrDropDown.id = 'attrDropDown';
    for (let i = 0; i < tab.length; i++) {
        let option = document.createElement('option');
        option.values = tab[i];
        option.text = tab[i];
        attrDropDown.appendChild(option);
    }
    let input = document.createElement('input');
    input.type = 'text';
    let div = document.createElement('div');
    let br = document.createElement('br');

    for (let i = 0; i < condNum; i++) {
        if (i === 0) {
            document.getElementById('condDiv').appendChild(attrDropDown.cloneNode(true));
            document.getElementById('condDiv').appendChild(opDropDown.cloneNode(true));
            document.getElementById('condDiv').appendChild(input.cloneNode(true));
            document.getElementById('condDiv').appendChild(br.cloneNode(true));
        } else {
            document.getElementById('condDiv').appendChild(opDropDown.cloneNode(true));
            document.getElementById('condDiv').appendChild(attrDropDown.cloneNode(true));
            document.getElementById('condDiv').appendChild(opDropDown.cloneNode(true));
            document.getElementById('condDiv').appendChild(input.cloneNode(true));
            document.getElementById('condDiv').appendChild(br.cloneNode(true));
        }
    }
}

function selSubmit() {
    var div =  document.getElementById('subDiv');
    div.innerHTML = "";
    var selectTable = document.getElementById('selectTab').value;
    var children = document.getElementById('condDiv').children;
    let condition = '';
    for (let i = 0; i < children.length; i++) {
        var child = children[i];
        if (child.nodeName !== "BR") {
            if (child.nodeName == "INPUT" & isNaN(child.value)) {
                condition = condition.concat("\'", child.value, "\'");
            } else {
                condition = condition.concat(" ", child.value, " ");
            }
        }
    }
    condition.trim();
    var form = document.createElement("form");
    form.method = "POST";
    form.action = "select-project.php";
    var selSubmit = document.createElement("input");
    selSubmit.type = "hidden";
    selSubmit.name = "selSubmit";
    selSubmit.id = "selSubmit";
    var condInput = document.createElement("input");
    condInput.type = "hidden";
    condInput.name = "condition";
    condInput.id = "condition";
    condInput.value = condition;
    var tabInput = document.createElement("input");
    tabInput.type = "hidden";
    tabInput.name = "selectTable";
    tabInput.id = "selectTable";
    tabInput.value = selectTable;
    var subInput = document.createElement("input");
    subInput.type = "submit";
    subInput.name = "submit";
    subInput.id = "submit";
    form.appendChild(condInput);
    form.appendChild(tabInput);
    form.appendChild(subInput);
    form.appendChild(selSubmit);
    div.appendChild(form);
}

function projFunc() {
    const div = document.getElementById('projDiv');
    div.innerHTML ="";
    let tabChoice = document.getElementById('projTab').value;
    let tab;
    if (tabChoice === 'Virus3') {
        tab = Virus;
    } else if (tabChoice === 'VaccineAgainst2') {
        tab = Vaccine;
    } else if (tabChoice === 'ViralDisease') {
        tab = Disease;
    }
    let form = document.createElement('form');
    form.name = 'projCheckBox';
    form.id = 'projCheckBox';

    for (let i = 0; i < tab.length; i++) {
        let input = document.createElement('input');
        input.id = tab[i];
        input.name = tab[i]
        input.value = tab[i]
        input.type = 'checkbox';
        let label = document.createElement('label');
        label.for = tab[i];
        label.innerHTML = tab[i];
        form.appendChild(input.cloneNode(true));
        form.appendChild(label.cloneNode(true));
    }
    div.appendChild(form.cloneNode(true));
}



function projSubmit() {
    var div = document.getElementById('projSub')
    div.innerHTML = "";
    var projTable = document.getElementById('projTab').value;
    var children = document.getElementById('projCheckBox').children;
    let columns = '';
    for (let i = 0; i < children.length; i++) {
        var child = children[i];
            if (child.checked) {
                columns = columns.concat(" ",child.value, ",");
            }
    }
    columns = columns.substring(0, columns.length-1)
    var form = document.createElement("form");
    form.method = "POST";
    form.action = "select-project.php";
    var projSubmit = document.createElement("input");
    projSubmit.type = "hidden";
    projSubmit.name = "projSubmit";
    projSubmit.id = "projSubmit";
    var columnInput = document.createElement("input");
    columnInput.type = "hidden";
    columnInput.name = "columns";
    columnInput.id = "columns";
    columnInput.value = columns;
    var tabInput = document.createElement("input");
    tabInput.type = "hidden";
    tabInput.name = "projTable";
    tabInput.id = "projTable";
    tabInput.value = projTable;
    var subInput = document.createElement("input");
    subInput.type = "submit";
    subInput.name = "submit";
    subInput.id = "submit";
    form.appendChild(columnInput);
    form.appendChild(tabInput);
    form.appendChild(projSubmit);
    form.appendChild(subInput);
    div.appendChild(form);
}

