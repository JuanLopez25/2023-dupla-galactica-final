Class {
	#name : #AccelerationCard,
	#superclass : #Object,
	#instVars : [
		'holder'
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
		cardManager activeCard: (self class create holder: color) ]
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

{ #category : #Effect }
AccelerationCard >> holder: aHolder [

	holder := aHolder
	
]

{ #category : #Initialization }
AccelerationCard >> intializeCreate [
	holder:= EmptyPlayer new.
]

{ #category : #Information }
AccelerationCard >> isEmpty [
	^false.
]

{ #category : #Information }
AccelerationCard >> isPermanent [

	^ true
]

{ #category : #Effect }
AccelerationCard >> selectTarget: anEmptyPlayer [ 
	
]
