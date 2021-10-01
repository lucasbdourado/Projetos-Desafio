function CloseGarage() {
    $("#garage-vehicles").html('');
	$("#app").hide();
    $.post('http://n2k_garage/CloseNUI', JSON.stringify({}));
}

$(document).keyup(function(e) {
    if (e.key === "Escape") {
       CloseGarage()
   }
});

$(document).ready(function(){

    $("#store-vehicle").click(function() {
        $("#app").hide();
        $("#garage-vehicles").html('');
        $.post('http://n2k_garage/StoreVehicle', JSON.stringify({}));
    });
    
    window.addEventListener('message', function(event) {
        var data = event.data;
        
        if (data.show) {
            if (data.locale === "garage"){
                $("#app").show();
                $('#store-vehicle').show();
                for (var i = 0; i < data.cars.length; i++) {
                    if (data.cars[i].display === 'NULL') {
                        data.cars[i].display = data.cars[i].model.toUpperCase();
                    }
                    console.log(data.cars[i].model)
                    $("#garage-vehicles").append(`
                                <div class="col-xs-12 col-sm-12 col-lg-4">
                                    <div class="card-model">
                                        <img src="./src/img/model/`+data.cars[i].model+`.png">
                                        <div class="card-header">
                                            <h2>`+data.cars[i].display+`</h2>
                                            <hr>
                                            <div class="row">
                                                <div class="d-flex justify-content-around col-6">
                                                    <p>Placa: </p><span>`+data.cars[i].vehicle.plate+`</span>
                                                </div>
                                                <div class="d-flex justify-content-around col-6">
                                                    <p>Estado Lataria: </p><span>`+(data.cars[i].vehicle.bodyHealth/10).toFixed(2)+`%</span>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="d-flex justify-content-around col-6">
                                                    <p>Estado Motor: </p><span>`+((data.cars[i].vehicle.engineHealth)/10).toFixed(2)+`%</span>
                                                </div>
                                            </div>
                                            <hr>
                                            <div class="d-flex justify-content-between">
                                                <span>Retirar Veículo:</span><button class="btn-success" id="carro" data-id=`+ i +`><i class="bi-check2"></i></button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                    `);
                }
                $(".card-header").find(":button").click(function() {
                    $("#app").hide();
                    $("#garage-vehicles").html('');
                    $.post('http://n2k_garage/SpawnVehicle', JSON.stringify({id: data.cars[$(this).data('id')]}));
                });
            }else if (data.locale === "security") {
                $('#store-vehicle').hide();
                $("#app").show();
                for (var i = 0; i < data.cars.length; i++) {
                    $("#garage-vehicles").append(`
                                <div class="col-xs-12 col-sm-12 col-lg-4">
                                    <div class="card-model">
                                        <img src="./src/img/model/`+data.vehInfo[i].modelo+`.png">
                                        <div class="card-header">
                                            <h2>`+data.vehInfo[i].modelo+`</h2>
                                            <hr>
                                            <div class="row">
                                                <div class="d-flex justify-content-around col-6">
                                                    <p>Placa: </p><span>`+data.cars[i].vehicle.plate+`</span>
                                                </div>
                                                <div class="d-flex justify-content-around col-6">
                                                    <p>Estado Lataria: </p><span>`+(data.cars[i].vehicle.bodyHealth/10).toFixed(2)+`%</span>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="d-flex justify-content-around col-6">
                                                    <p>Estado Motor: </p><span>`+((data.cars[i].vehicle.engineHealth)/10).toFixed(2)+`%</span>
                                                </div>
                                            </div>
                                            <hr>
                                            <div class="d-flex justify-content-between">
                                                <span>Retirar Veículo:</span><button class="btn-success" id="carro" data-id=`+ i +`><i class="bi-check2"></i></button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                    `);
                }
                $(".card-header").find(":button").click(function() {
                    $("#app").hide();
                    $("#garage-vehicles").html('');
                    $.post('http://n2k_garage/SpawnVehicleSecurity', JSON.stringify({id: data.cars[$(this).data('id')]}));
                });
            }
        }
    });
});