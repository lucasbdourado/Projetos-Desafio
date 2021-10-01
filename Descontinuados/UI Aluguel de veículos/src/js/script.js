const carros_aluguel = [
    {model: "blista", label: "Blista", valor: 200},
    {model: "brioso", label: "Brioso", valor: 200},
    {model: "ingot", label: "Ingot", valor: 200},
    {model: "primo", label: "Primo", valor: 400},
    {model: "premier", label: "Premier", valor: 500},
    {model: "jester3", label: "Jester Classic", valor: 500},
    {model: "coquette4", label: "Coquette 2020", valor: 500},
    {model: "akuma", label: "Akuma", valor: 500},
    {model: "emerus", label: "Emerus", valor: 500},
    {model: "weevil", label: "Weevil", valor: 500},
    {model: "asea", label: "Asea", valor: 600},
    {model: "buccaneer2", label: "Buccaneer Custom", valor: 200}
]

for(let i = 0; i < carros_aluguel.length; i++){
    console.log(i+". "+carros_aluguel[i].label);

    $("#vehicles-menu").append(`<div class="col-xs-12 col-sm-6 col-lg-4">
    <img src="./src/img/model/`+carros_aluguel[i].model+`.png">
    <span class="name-tag">`+carros_aluguel[i].label+`</span>
    <div class="card-footer-ten">
        <span class="valor-aluguel">R$ `+carros_aluguel[i].valor+` / HR</span>
        <button class="btn-buy" data-id="`+i+`">Alugar</button>
    </div>
</div>`);
}




$("#modal-confirm").hide();

$(".btn-buy").on( "click", function( event ) {

    $("#modal-confirm").show();

    let carID = $(this).data('id');
    console.log(carID);

    $(".modal-vehicle-confirm").html(`
        <h1>Confirme seu Aluguel:</h1>
        <img src="./src/img/model/`+carros_aluguel[carID].model+`.png">
        <hr>
        <p>Para podermos Liberar seu aluguel você precisará confirmar alguns dados. Assim que estes dados estiverem confirmados clique em "Confirmar Aluguel".</p>
        <div class="d-flex justify-content-between align-items-center">
            <div><h5>Modelo:</h5></div><div><h5>`+carros_aluguel[carID].label+`</h5></div>
        </div>
        <div class="d-flex justify-content-between align-items-center">
            <div><h5>Cor:</h5></div>
            <div class="color-picker"></div>
        </div>
        <hr>
        <div class="d-flex justify-content-between align-items-end">
            <div><h5>Preço:</h5></div><div><h5>R$ `+carros_aluguel[carID].valor+` / HR</h5></div>
        </div>
        <p>OBS: Se todos os dados estiverem corretos clique em "Confirmar Aluguel".</p>
        <div class="row justify-content-center"><button class="btn-confirm" onclick="myFunction()">Confirmar Aluguel</button></div>
        `
    );

    const pickr = Pickr.create({
        el: '.color-picker',
        theme: 'classic', // or 'monolith', or 'nano'
    
        swatches: [
            'rgba(244, 67, 54, 1)',
            'rgba(233, 30, 99, 0.95)',
            'rgba(156, 39, 176, 0.9)',
            'rgba(103, 58, 183, 0.85)',
            'rgba(63, 81, 181, 0.8)',
            'rgba(33, 150, 243, 0.75)',
            'rgba(3, 169, 244, 0.7)',
            'rgba(0, 188, 212, 0.7)',
            'rgba(0, 150, 136, 0.75)',
            'rgba(76, 175, 80, 0.8)',
            'rgba(139, 195, 74, 0.85)',
            'rgba(205, 220, 57, 0.9)',
            'rgba(255, 235, 59, 0.95)',
            'rgba(255, 193, 7, 1)'
        ],
    
        components: {
    
            // Main components
            preview: false,
            opacity: true,
            hue: true,
    
            // Input / output Options
            interaction: {
                hex: false,
                rgba: false,
                hsla: false,
                hsva: false,
                cmyk: false,
                input: false,
                clear: false,
                save: true
            }
        }
    });

    pickr.on('save', (...args) => {
        console.log(args[0].toRGBA());
    });
    
});

function myFunction(){
    $("#modal-confirm").hide();
}