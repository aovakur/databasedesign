Имеется предметная область «Сбытовая логистика – Бухгалтерия дебиторов. 
Предметная область представлена следующим набором сущностей: 

Контракт - долгосрочное рамочное соглашение между сторонами; 
Заказ - краткосрочное соглашение на поставку в рамках контракта, обычно – месячное доп. соглашение; 
Поставка - товарно - транспортная накладная, документ, отражающий факт поставки по заказу;
Фактура - документ, отражающий переход права собственности на поставляемый товар и акцепт Заказчиком дебиторской задолженности. Фактура может выставляться на одну или несколько поставок;
Платеж - документ, отражающий факт поступления денег от Заказчика. Платежи могут поступать авансом или по факту поставки в погашение задолженности;
Документ выравнивания - документ, отражающий сопоставление данных платежей и фактур, отражает бухгалтерский факт погашения дебиторской задолженности. 

1.1 Контракт:  Основные характеристики: Период действия (год) Заказчик (Регион, Страна, - «Россия и Белоруссия– СНГ – Дальнее зарубежье»); Продукт – Группа продуктов; Показатели: Объем по договору; Стоимость по договору; Договорная цена позиции Контракта. 
1.2 Заказ 
Содержит уточненный на месяц объем поставки, уточнения по ценам. Наследует характеристики контракта. Кроме того, содержит дополнительные сведения: Период действия заказа (Месяц) Требуемая дата поставки; Показатели: Объем по заказу, Стоимость по заказу; Договорная цена позиции Заказа. 
1.3 Поставка Наследует атрибутику заказа, кроме того, содержит следующие признаки: Дата отгрузки (с Предприятия); Дата передачи права собственности (Заказчику). 
2 Показатели: Объем поставки; Стоимость поставки. 
1.4 Фактура:  Наследует атрибутику поставок, кроме того, содержит признаки: Дата фактуры (возникновения дебиторской задолженности); Планируемая дата погашения дебиторской задолженности. Показатели: Объем по фактуре; Стоимость по фактуре. 
1.5 Платеж Содержит признаки: Контракт; Заказчик; Дата платежа Показатели: Сумма платежа; 
1.6 Документ выравнивания Наследует признаки фактуры и платежа. Кроме того, содержит следующие признаки: Дата выравнивания (погашения дебиторской задолженности) Показатели: Сумма выравнивания. 

Схема информационного Хранилища в виде ER – диаграммы

![screenshot of sample](https://github.com/aovakur/databasedesign/picture.png)