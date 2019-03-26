function formata_decimal(campo, casas) {

    var strCheck = '-0123456789,';

    if (campo.value.length == 0) {
        campo.value = '0';
    }
    index = campo.value.indexOf(',')
    if (index == -1) {
        for (var x = 0; x < casas; x++)
            campo.value += "0";
    } else {

        casas_valor = (campo.value.substring(index, campo.value.length).length - 1);

        casas_sobra = casas_valor - casas;

        if (casas_sobra > 0) {
            campo.value = campo.value.substring(0, campo.value.length - casas_sobra);
        }

        for (var y = 0; y < (casas - casas_valor); y++) {
            campo.value += "0";
        }


    }

    var aux = aux2 = '';
    var i = j = 0;
    len = campo.value.length;
    qtdVirgula = 0;
    for (; i < len; i++) {
        aux += campo.value.charAt(i);
        if (strCheck.indexOf(campo.value.charAt(i)) == -1) {
            campo.style.backgroundColor = "#f88";
            campo.value = '';
            return true;
        }

        if (campo.value.charAt(i) == ',') {
            qtdVirgula += 1;
        }

    }
    aux = aux.toString().replace(/\$|\,/g, '');

    if (qtdVirgula > 1) {
        campo.style.backgroundColor = "#f88";
        campo.value = '';
        return true;
    }

    len = aux.length;

    for (j = 0; j <= len; j++) {
        if ((len - j) == casas) {
            aux2 += ',';
        }
        aux2 += aux.charAt(j);
    }

    campo.value = aux2;
    campo.style.backgroundColor = "white";
    return false;
}