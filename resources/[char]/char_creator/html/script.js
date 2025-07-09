function submit() {
    const firstname = document.getElementById('firstname').value;
    const lastname = document.getElementById('lastname').value;
    const dob = document.getElementById('dob').value;
    const gender = document.getElementById('gender').value;

    if (!firstname || !lastname || !dob || !gender) {
        alert("Bitte fülle alle Felder aus.");
        return;
    }

    fetch(`https://${GetParentResourceName()}/submitData`, {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({firstname, lastname, dob, gender})
    });
}
