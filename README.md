# HCalory PowerPole Connector replacement
3D printable part to replace the panelmount DC connector with Anderson PowerPole plugs for the Hcalory EC30 portable/car fridge, as the connector on mine had melted ([see picture below](#original-melty-connector)).

The original connector is a misuse of the IEC (AC) connector C11/C12, which a lot of portable fridge manufacturers seem to use on their devices. This replacement fits the original hole in the panel and replaces the C12 connector with an Anderson PowerPole PP15/30/45.

Be aware, **the original connector has an integrated fuseholder, so a fuse has to be added between the PowerPole connector and the internal connections** to avoid risk of fire and other damage to the device!
The design could easily be adapted to fit a fuse holder as there is a lot of space, but I didn't do that as I didn't have one on hand.

### OpenSCAD model
The part is put together from the cover plate and the extruded panel hole, from which the PowerPole Connector is subtracted. The part is then split in two printable parts, which are held together by both the connector and one of the mounting screws.

The `pp45()` module (with its associated variables) is probably useful for other projects which include PowerPole connectors as well.

## Pictures
### Model
The model is designed as one whole unit, which is then split into two printable parts that fit together.

![Entire Model](images/photo_3_2023-11-12_02-15-17.jpg)

![Model split into printable parts](images/photo_4_2023-11-12_02-15-17.jpg)

### Sliced Model
This was sliced with PrusaSlicer with the supports for the outer PowerPole peg holes removed on both halves (as they aren't needed) so only the center support stays.

![](images/photo_1_2023-11-12_02-15-17.jpg)

### Print

![](images/photo_5_2023-11-12_02-15-17.jpg)
![](images/photo_6_2023-11-12_02-15-17.jpg)

![](images/photo_7_2023-11-12_02-15-17.jpg)
![](images/photo_8_2023-11-12_02-15-17.jpg)

### 

### Original (melty) connector
Here, the plastic around the positive pin of the socket has melted, likely due to bad contact resistance. The pin on the plug side has melted as well.

![Original connector](images/photo_2023-11-10_16-22-33.jpg)