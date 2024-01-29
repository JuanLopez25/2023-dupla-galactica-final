Class {
	#name : #LigthYear,
	#superclass : #Object,
	#instVars : [
		'nominalValue'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
LigthYear class >> worth: aNominalValue [

	^ self new initializeWorth: aNominalValue
]

{ #category : #initialization }
LigthYear >> initializeWorth: aNominalValue [

	nominalValue := aNominalValue
]

{ #category : #information }
LigthYear >> lightYears [

	^ self
]

{ #category : #information }
LigthYear >> nominalValue [

	^ nominalValue
]

{ #category : #information }
LigthYear >> parsecs [

	^ Parsec worth: nominalValue // 3
]
