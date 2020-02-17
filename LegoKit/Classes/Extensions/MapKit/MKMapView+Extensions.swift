//
//  MKMapView+Extensions.swift
//  LegoKit
//
//  Created by forkon on 2020/2/13.
//

import MapKit

extension MKMapView {

    public func updateRegionToShowAllAnnotationsAndOverlays(animated: Bool = true) {
        if let regionContainsAllAnnotations = regionContainsAllAnnotations {
            setRegion(regionThatFits(regionContainsAllAnnotations), animated: animated)

            if let regionContainsAllOverlays = regionContainsAllOverlays {
                setRegion(regionThatFits(regionContainsAllOverlays), animated: animated)
            }
        } else {
            if let regionContainsAllOverlays = regionContainsAllOverlays {
                setRegion(regionThatFits(regionContainsAllOverlays), animated: animated)
            }
        }
    }

    public func region(for annotations: [MKAnnotation]) ->
         MKCoordinateRegion {
      let region: MKCoordinateRegion

      switch annotations.count {
      case 0:
        region = self.region
      case 1:
        let annotation = annotations[annotations.count - 1]
        region = MKCoordinateRegion(
          center: annotation.coordinate,
          latitudinalMeters: 1000,
          longitudinalMeters: 1000
        )
      default:
        var topLeft = CLLocationCoordinate2D(latitude: -90,
                                            longitude: 180)
        var bottomRight = CLLocationCoordinate2D(latitude: 90,
                                          longitude: -180)

        for annotation in annotations {
            topLeft.latitude = max(topLeft.latitude, annotation.coordinate.latitude)
            topLeft.longitude = min(topLeft.longitude,
                                    annotation.coordinate.longitude)
            bottomRight.latitude = min(bottomRight.latitude,
                                       annotation.coordinate.latitude)
            bottomRight.longitude = max(bottomRight.longitude,
                              annotation.coordinate.longitude)
        }

        let center = CLLocationCoordinate2D(
            latitude: topLeft.latitude -
                     (topLeft.latitude - bottomRight.latitude) / 2,
            longitude: topLeft.longitude -
                   (topLeft.longitude - bottomRight.longitude) / 2)

        let extraSpace = 1.5
          let span = MKCoordinateSpan(
            latitudeDelta: abs(topLeft.latitude -
                           bottomRight.latitude) * extraSpace,
            longitudeDelta: abs(topLeft.longitude -
                            bottomRight.longitude) * extraSpace)
          region = MKCoordinateRegion(center: center, span: span)
        }

        return regionThatFits(region)
    }

    public var regionContainsAllAnnotations: MKCoordinateRegion? {
        return region(for: annotations.filter{$0.coordinate.latitude != 0 && $0.coordinate.longitude != 0})
    }

    public var regionContainsAllOverlays: MKCoordinateRegion? {
        var boundingMapRect: MKMapRect? = nil

        overlays.forEach({ (overlay) in
            if boundingMapRect != nil {
                boundingMapRect = boundingMapRect?.union(overlay.boundingMapRect)
            } else {
                boundingMapRect = overlay.boundingMapRect
            }
        })

        if let boundingMapRect = boundingMapRect {
            return MKCoordinateRegion(boundingMapRect.insetBy(dx: -boundingMapRect.width / 10.0, dy: -boundingMapRect.height / 10.0))
        } else {
            return nil
        }
    }

}
