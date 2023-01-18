//(function readyJS(win, doc){
'use strict'

const LinhaServicos = {

    Validarlinha: function () {
        

        let txblinha = document.querySelector(".Linha");

        console.log(txblinha.value.length);

        if (txbLinha.value.length > 0) {
            post(window.location.origin + "/Cadastros/LinhaServico/Formulario.aspx/ValidarLinhaServicos", { linha: txblinha.value },
                function (data) {
                    console.log(data.d);
                    console.log(typeof data.d);

                    if (!data.d) {
                        exibirAlert('Linha de Serviços já foi cadastrada.', 'bg-danger');
                        txblinha.value = "";
                    }
                }, function (erro) {
                    exibirAlert('Ocorreu um erro ao validar  a Linha de Serviços.', 'bg-danger');
                });
        }
    },

    
}
//})(window, document); 