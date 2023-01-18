'use strict'

const CategoriaServicos = {

    Validarcategoria: function () {
        

        let txbcategoria = document.querySelector(".CategoriaServicos");

        console.log(txbcategoria.value.length);

        if (txbcategoria.value.length > 0) {
            post(window.location.origin + "/Cadastros/CategoriaServicos/Formulario.aspx/ValidarCategoriaServicos", { linha: txbcategoria.value },
                function (data) {
                    console.log(data.d);
                    console.log(typeof data.d);

                    if (!data.d) {
                        exibirAlert('A Categoria de Serviços em questão, já foi cadastrado.', 'bg-danger');
                        txbcategoria.value = "";
                    }
                }, function (erro) {
                    exibirAlert('Ocorreu um erro ao validar  a Categoria Serviços.', 'bg-danger');
                });
        }
    },

    
}
