const DNAVirus = ["GenomeShape"];
const RNAVirus = ["Sense"];
const op = [">", ">", "=", ">=", "<=", "AND", "OR", "<>"];


function joinCondFunc() {
    let condNum = document.getElementById('CondiCount').value;
    const div = document.getElementById('condDiv');
    div.innerHTML = "";
    let tab = ["Genus", "Status", "TransmissionType"];
    let tabChoice = document.getElementById('joinSel').value;

    if (tabChoice === 'RNA Virus') {
        tab = tab.concat(RNAVirus);
        var selSubmit = document.createElement("input");
    } else if (tabChoice === 'DNA Virus') {
        tab = tab.concat(DNAVirus);
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
    var div = document.getElementById('subDiv');
    div.innerHTML = "";
    var tabChoice = document.getElementById('joinSel').value;
    var children = document.getElementById('condDiv').children;
    let condition = '';
    var form = document.createElement("form");
    form.method = "POST";
    form.action = "join-div.php";
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
    if (tabChoice === 'RNA Virus') {
        var RNAcondition = document.createElement("input");
        RNAcondition.type = "hidden";
        RNAcondition.name = "RNAcondition";
        RNAcondition.id = "RNAcondition";
        RNAcondition.value = condition;
        form.appendChild(RNAcondition);
        var RNAJoinSubmit = document.createElement("input");
        RNAJoinSubmit.type = "hidden";
        RNAJoinSubmit.name = "RNAJoinSubmit";
        RNAJoinSubmit.id = "RNAJoinSubmit";
        form.appendChild(RNAJoinSubmit);
    } else if (tabChoice === 'DNA Virus') {
        var DNAcondition = document.createElement("input");
        DNAcondition.type = "hidden";
        DNAcondition.name = "DNAcondition";
        DNAcondition.id = "DNAcondition";
        DNAcondition.value = condition;
        form.appendChild(DNAcondition);
        var DNAJoinSubmit = document.createElement("input");
        DNAJoinSubmit.type = "hidden";
        DNAJoinSubmit.name = "DNAJoinSubmit";
        DNAJoinSubmit.id = "DNAJoinSubmit";
        form.appendChild(DNAJoinSubmit);
    }
    var subInput = document.createElement("input");
    subInput.type = "submit";
    subInput.name = "submit";
    subInput.id = "submit";
    var joinSubmit = document.createElement("input");
    joinSubmit.type = "hidden";
    joinSubmit.name = "joinSubmit";
    joinSubmit.id = "joinSubmit";
    form.appendChild(joinSubmit);
    form.appendChild(subInput);
    div.appendChild(form);
}