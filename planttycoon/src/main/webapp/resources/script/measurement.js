/**
 * home.jsp 와 plant/status.jsp가 같은 로직을 활용하여 센서값을 화면에 표시하기에
 * 재사용성을 높이고 중복을 줄이고자 분리한 자바스크립트 파일
 */
 
$(window).on("load", function() {
	const currentPlant = $('#currentPlant').val();
    fetch(`${ctx}/resources/json/plantsData.json`)
    	.then(response => response.json())
        .then(data => {
        	const selectedPlant = data.find(plant => plant.plant_name === currentPlant);
        	if (selectedPlant) {
        		
        		const minTemperature = selectedPlant.min_temperature_celcius;
    		    const maxTemperature = selectedPlant.max_temperature_celcius;
    		    
    		    const minHumidity = selectedPlant.min_humidity_percentage;
    		    const maxHumidity = selectedPlant.max_humidity_percentage;
    		    
    		    const minLight = selectedPlant.min_light_lux;
    		    const maxLight = selectedPlant.max_light_lux;
    		    
    		    const minSoilMoisture = selectedPlant.min_soil_moisture_percentage;
    		    const maxSoilMoisture = selectedPlant.max_soil_moisture_percentage;
        		
			    $('#minTemperature').html(minTemperature);
			    $('#maxTemperature').html(maxTemperature);
			    $('#minHumidity').html(minHumidity);
			    $('#maxHumidity').html(maxHumidity);
			    $('#minLight').html(minLight);
			    $('#maxLight').html(maxLight);
			    $('#minSoilMoisture').html(minSoilMoisture);
			    $('#maxSoilMoisture').html(maxSoilMoisture);
			    
			 	// 온도
			    const temperature = parseInt(document.getElementById('temperatureValue').textContent);
			    const temperatureStatus = document.getElementById('temperatureStatus').querySelector('.status-indicator');
			    if (temperature < minTemperature) {
			        temperatureStatus.classList.add('low');
			        temperatureStatus.classList.remove('high', 'ok');
			    } else if (temperature > maxTemperature) {
			        temperatureStatus.classList.add('high');
			        temperatureStatus.classList.remove('low', 'ok');
			    } else {
			        temperatureStatus.classList.add('ok');
			    }
			    
			    // 대기 습도
			    const humidity = parseInt(document.getElementById('humidityValue').textContent);
			    const humidityStatus = document.getElementById('humidityStatus').querySelector('.status-indicator');
			    if (humidity < minHumidity) {
			        humidityStatus.classList.add('low');
			        humidityStatus.classList.remove('high', 'ok');
			    } else if (humidity > maxHumidity) {
			        humidityStatus.classList.add('high');
			        humidityStatus.classList.remove('low', 'ok');
			    } else {
			        humidityStatus.classList.add('ok');
			        humidityStatus.classList.remove('low', 'high');
			    }

			    // 조도
			    const illuminance = parseInt(document.getElementById('lightValue').textContent);
			    const lightStatus = document.getElementById('lightStatus').querySelector('.status-indicator');
			    if (illuminance < minLight) {
			        lightStatus.classList.add('low');
			        lightStatus.classList.remove('high', 'ok');
			    } else {
			        lightStatus.classList.add('ok');
			        lightStatus.classList.remove('low', 'high');
			    }

			    // 토양 습도
			    const soilMoisture = parseInt(document.getElementById('soilMoistureValue').textContent);
			    const soilMoistureStatus = document.getElementById('soilMoistureStatus').querySelector('.status-indicator');
			    if (soilMoisture < minSoilMoisture) {
			        soilMoistureStatus.classList.add('low');
			        soilMoistureStatus.classList.remove('high', 'ok');
			    } else if (soilMoisture > maxSoilMoisture) {
			        soilMoistureStatus.classList.add('high');
			        soilMoistureStatus.classList.remove('low', 'ok');
			    } else {
			        soilMoistureStatus.classList.add('ok');
			        soilMoistureStatus.classList.remove('low', 'high');
			    }
			    
        	} else {
        		$('#minTemperature').html('');
			    $('#maxTemperature').html('');
			    $('#minHumidity').html('');
			    $('#maxHumidity').html('');
			    $('#minLight').html('');
			    $('#maxLight').html('');
			    $('#minSoilMoisture').html('');
			    $('#maxSoilMoisture').html('');
			    const statusIndicator = $('.status-indicator');
			    statusIndicator.css('display','none');
			    const optimalConditionText = $('.gray');
			    optimalConditionText.css('display', 'none');
        	}
        })
        .catch(error => console.error('Error fetching data:', error));
});