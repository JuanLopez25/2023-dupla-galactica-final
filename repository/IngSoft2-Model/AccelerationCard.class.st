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

	^ self new intializeCreate
]

{ #category : #comparing }
AccelerationCard >> = aCard [

	(aCard isKindOf: self class)
		ifTrue: [ ^ aCard holder = holder ]
		ifFalse: [ ^ false ]
]

{ #category : #effect }
AccelerationCard >> applyCardUsing: cardManager at: aGame [

	cardManager activeCard: (self class create newHolder: holder)
]

{ #category : #effect }
AccelerationCard >> applyEffect [

	^ 1
]

{ #category : #information }
AccelerationCard >> hasEffect [

	^ true
]

{ #category : #information }
AccelerationCard >> holder [

	^ holder
]

{ #category : #initialization }
AccelerationCard >> intializeCreate [

	holder := EmptyObject new.
	target := EveryPlayer new
]

{ #category : #information }
AccelerationCard >> isEmpty [

	^ false
]

{ #category : #information }
AccelerationCard >> isPermanent [

	^ true
]

{ #category : #effect }
AccelerationCard >> newHolder: aHolder [

	holder := aHolder
	
]

{ #category : #effect }
AccelerationCard >> selectTarget: aPlayer [



]

{ #category : #information }
AccelerationCard >> target [

	^ target
]
