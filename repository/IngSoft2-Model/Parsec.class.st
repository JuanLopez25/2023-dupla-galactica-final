Class {
	#name : #Parsec,
	#superclass : #Object,
	#instVars : [
		'nominalValue'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
Parsec class >> worth: aNominalValue [

	^ self new initializeWith: aNominalValue
]

{ #category : #initialization }
Parsec >> initializeWith: aNominalValue [

	nominalValue := aNominalValue
]

{ #category : #information }
Parsec >> lightYears [

	^ LigthYear worth: nominalValue * 3
]

{ #category : #information }
Parsec >> nominalValue [

	^ nominalValue
]

{ #category : #information }
Parsec >> parsecs [

	^ self
]
