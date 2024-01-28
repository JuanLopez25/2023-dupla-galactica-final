Class {
	#name : #AccelerationCard,
	#superclass : #Object,
	#instVars : [
		'holder',
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Intance creation' }
AccelerationCard class >> create [
	^self new intializeCreate.
]

{ #category : #Information }
AccelerationCard >> = aCard [

	(aCard isKindOf: self class)
		ifTrue: [ ^ aCard holder = holder ]
		ifFalse: [ ^ false ]
]

{ #category : #Effect }
AccelerationCard >> applyCardUsing: cardManager at: aGame [ 

	aGame playersColors do: [ :color | 
		cardManager activeCard: ((self class create newHolder: holder) selectTarget: color) ]
]

{ #category : #Effect }
AccelerationCard >> applyEffect [

	^ 1
]

{ #category : #Information }
AccelerationCard >> haveEffect [

	^ true
]

{ #category : #Information }
AccelerationCard >> holder [

	^ holder
]

{ #category : #Initialization }
AccelerationCard >> intializeCreate [
	holder:= EmptyObject new.
	target:= EmptyObject new.
]

{ #category : #Information }
AccelerationCard >> isEmpty [

	^ false
]

{ #category : #Information }
AccelerationCard >> isPermanent [

	^ true
]

{ #category : #Effect }
AccelerationCard >> newHolder: aHolder [

	holder := aHolder
	
]

{ #category : #Effect }
AccelerationCard >> selectTarget: aPlayer [

	target:= aPlayer.
	

]

{ #category : #Information }
AccelerationCard >> target [

	^ target
]
