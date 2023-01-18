
'use strict'

const ProdutoNacional = {

    ValidarprodutoNacional: function () {
        

        let txbprodutoNacional = document.querySelector(".ProdutoNacional");

        console.log(txbprodutoNacional.value.length);

        if (txbprodutoNacional.value.length > 0) {
            post(window.location.origin + "/Cadastros/ProdutoNacional/Formulario.aspx/ValidarProdutoNacional", { linha: txbprodutoNacional.value },
                function (data) {
                    console.log(data.d);
                    console.log(typeof data.d);

                    if (!data.d) {
                        exibirAlert('O Produto Nacional em questão, já foi cadastrado.', 'bg-danger');
                        txbprodutoNacional.value = "";
                    }
                }, function (erro) {
                    exibirAlert('Ocorreu um erro ao validar  o Produto Nacional.', 'bg-danger');
                });
        }
    },

   
}
