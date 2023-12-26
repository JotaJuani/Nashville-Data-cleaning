SELECT * 
FROM HousingNashville..NashvilleHousing

--Standardize Date Format	

SELECT SaleDateConverted, CONVERT(DATE,SaleDate)
FROM HousingNashville..NashvilleHousing

UPDATE NashvilleHousing
SET SaleDate= CONVERT(Date,SaleDate)

ALTER TABLE NashvilleHousing
ADD SaleDateConverted DATE;


UPDATE NashvilleHousing
SET SaleDateConverted = CONVERT(Date,SaleDate)

--Populate Properrty Adress Data

SELECT PropertyAddress
FROM HousingNashville..NashvilleHousing
WHERE PropertyAddress IS NULL 

--Copying the same propertyadress if the parcelid is the same 

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM HousingNashville..NashvilleHousing a
JOIN HousingNashville..NashvilleHousing b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL 

UPDATE a 
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM HousingNashville..NashvilleHousing a
JOIN HousingNashville..NashvilleHousing b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL


--Divide address into (Addres, City, State)

SELECT PropertyAddress
FROM HousingNashville..NashvilleHousing

SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) AS Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 , LEN(PropertyAddress)) AS Address
FROM HousingNashville..NashvilleHousing

--columns final splits


ALTER TABLE NashvilleHousing
ADD PropertySplitAddress nvarchar(255);


UPDATE NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1)

ALTER TABLE NashvilleHousing
ADD PropertySplitCity nvarchar(255);


UPDATE NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 , LEN(PropertyAddress))

--
SELECT *
FROM HousingNashville..NashvilleHousing


--Split owneraddress

SELECT OwnerAddress
FROM HousingNashville..NashvilleHousing

SELECT 
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3),
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2),
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
FROM HousingNashville..NashvilleHousing


--
ALTER TABLE NashvilleHousing
ADD OwnerSplitAddress nvarchar(255);
UPDATE NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)



ALTER TABLE NashvilleHousing
ADD OwnerSplitCity nvarchar(255);
UPDATE NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)




ALTER TABLE NashvilleHousing
ADD OwnerSplitState nvarchar(255);
UPDATE NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)

SELECT *
FROM HousingNashville..NashvilleHousing



-- Fixing values y/n
SELECT DISTINCT (SoldAsVacant), COUNT(SoldAsVacant)
FROM HousingNashville..NashvilleHousing
GROUP BY (SoldAsVacant)
ORDER BY 2



SELECT SoldAsVacant,
CASE WHEN SoldAsVacant = 'Y' THEN 'YES'
	WHEN SoldAsVacant = 'N' THEN 'NO'
	ELSE SoldAsVacant
	END
FROM HousingNashville..NashvilleHousing

UPDATE NashvilleHousing
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'YES'
	WHEN SoldAsVacant = 'N' THEN 'NO'
	ELSE SoldAsVacant
	END

---
SELECT *,
ROW_NUMBER() OVER(
	PARTITION BY ParcelID,
	PropertyAddress,
	SalePrice,
	SaleDate,
	LegalReference
	ORDER BY UniqueID) row_num
FROM HousingNashville..NashvilleHousing
ORDER BY ParcelID



with RowNumCTE AS(
SELECT * 
SELECT * 
FROM HousingNashville..NashvilleHousing

--Standardize Date Format	



SELECT SaleDateConverted, CONVERT(DATE,SaleDate)
FROM HousingNashville..NashvilleHousing

UPDATE NashvilleHousing
SET SaleDate= CONVERT(Date,SaleDate)

ALTER TABLE NashvilleHousing
ADD SaleDateConverted DATE;


UPDATE NashvilleHousing
SET SaleDateConverted = CONVERT(Date,SaleDate)

--Populate Properrty Adress Data

SELECT PropertyAddress
FROM HousingNashville..NashvilleHousing
WHERE PropertyAddress IS NULL 

--Copying the same propertyadress if the parcelid is the same 

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM HousingNashville..NashvilleHousing a
JOIN HousingNashville..NashvilleHousing b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL 

UPDATE a 
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM HousingNashville..NashvilleHousing a
JOIN HousingNashville..NashvilleHousing b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL


--Divide address into (Addres, City, State)

SELECT PropertyAddress
FROM HousingNashville..NashvilleHousing

SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) AS Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 , LEN(PropertyAddress)) AS Address
FROM HousingNashville..NashvilleHousing

--columns final splits


ALTER TABLE NashvilleHousing
ADD PropertySplitAddress nvarchar(255);


UPDATE NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1)

ALTER TABLE NashvilleHousing
ADD PropertySplitCity nvarchar(255);


UPDATE NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 , LEN(PropertyAddress))

--
SELECT *
FROM HousingNashville..NashvilleHousing


--Split owneraddress

SELECT OwnerAddress
FROM HousingNashville..NashvilleHousing

SELECT 
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3),
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2),
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
FROM HousingNashville..NashvilleHousing


--
ALTER TABLE NashvilleHousing
ADD OwnerSplitAddress nvarchar(255);
UPDATE NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)



ALTER TABLE NashvilleHousing
ADD OwnerSplitCity nvarchar(255);
UPDATE NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)




ALTER TABLE NashvilleHousing
ADD OwnerSplitState nvarchar(255);
UPDATE NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)

SELECT *
FROM HousingNashville..NashvilleHousing



-- Fixing values y/n
SELECT DISTINCT (SoldAsVacant), COUNT(SoldAsVacant)
FROM HousingNashville..NashvilleHousing
GROUP BY (SoldAsVacant)
ORDER BY 2



SELECT SoldAsVacant,
CASE WHEN SoldAsVacant = 'Y' THEN 'YES'
	WHEN SoldAsVacant = 'N' THEN 'NO'
	ELSE SoldAsVacant
	END
FROM HousingNashville..NashvilleHousing

UPDATE NashvilleHousing
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'YES'
	WHEN SoldAsVacant = 'N' THEN 'NO'
	ELSE SoldAsVacant
	END

---
WITH RowNumCTE as(
SELECT *,
ROW_NUMBER() OVER(
	PARTITION BY ParcelID,
	PropertyAddress,
	SalePrice,
	SaleDate,
	LegalReference
	ORDER BY UniqueID) row_num
FROM HousingNashville..NashvilleHousing
)
SELECT *
FROM RowNumCTE
WHERE row_num > 1



--DELETE UNUSED COLUMNS

ALTER TABLE HousingNashville..NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate

SELECT * 
FROM HousingNashville..NashvilleHousing